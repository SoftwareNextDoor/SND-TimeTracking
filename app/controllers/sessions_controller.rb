require 'httparty'

class SessionsController < ApplicationController

  include HTTParty

  def new
    @title = "Sign in"
  end

  def signout_revoke
    @title = 'Sign Out'

        @sfloguturl = nil

        if params[:orgurl] != nil

            #Set ifram url for salesforce logout
            @sfloguturl = "#{params[:orgurl]}/secur/logout.jsp"

            #Revoke refresh token
            if signed_in?
                result = HTTParty.post("#{params[:orgurl]}/services/oauth2/revoke",:body => "token= #{session[:auth_hash][:refresh_token]}")
                puts "Revoke post response = "+result.inspect
            end
        end

        if params[:sm] == '1'
            store_location
        end

    session[:client] = nil
    reset_session
  end

  def login
    redirect_to root_path
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def create

    puts 'Full Auth Hash >>>>>'
    puts request.env['omniauth.auth']
    puts 'REFRESH TOKEN >>>>>>>'
    puts request.env['omniauth.auth']['credentials']['refresh_token']
    puts 'User Login >>>>'
    session[:auth_hash] = request.env['omniauth.auth']['credentials']
    puts 'tokens: '+request.env['omniauth.auth']['credentials'].to_s
    session[:user_id] = request.env['omniauth.auth']['extra']['user_id']
    puts 'user id: '+request.env['omniauth.auth']['extra']['user_id'].to_s
    session[:org_id] = request.env['omniauth.auth']['extra']['organization_id']
    puts 'org id: '+request.env['omniauth.auth']['extra']['organization_id'].to_s
    session[:image] = request.env['omniauth.auth']['info']['image']
    puts 'image : '+request.env['omniauth.auth']['info']['image'].to_s
    session[:name] = request.env['omniauth.auth']['info']['name']
    puts 'name : '+request.env['omniauth.auth']['info']['name'].to_s

    #obtain name of the service
    params[:provider] ? service_route = params[:provider] : service_route = 'No service recognized (invalid callback)'

    # get the full hash from omniauth
    omniauth = request.env['omniauth.auth']

    # continue only if hash and parameter exist
    if omniauth and params[:provider]

      client = Databasedotcom::Client.new
      client.version = "23.0"
      case params[:provider] 
        when 'salesforce'
          client.client_id = ENV['SALESFORCE_KEY']
          client.client_secret = ENV['SALESFORCE_SECRET']
        when 'salesforcesandbox'
          client.client_id = ENV['SALESFORCE_SANDBOX_KEY']
          client.client_secret = ENV['SALESFORCE_SANDBOX_SECRET']
        when 'salesforceprerelease'
          client.client_id = ENV['SALESFORCE_PRERELEASE_KEY']
          client.client_secret = ENV['SALESFORCE_PRERELEASE_SECRET']
        when 'databasedotcom'
          client.client_id = ENV['DATABASE_DOT_COM_KEY']
          client.client_secret = ENV['DATABASE_DOT_COM_SECRET']
        when 'customurl'
          client.client_id = ENV['SALESFORCE_CUSTOM_KEY']
          client.client_secret = ENV['SALESFORCE_CUSTOM_SECRET']
      end

      instUrl = session[:auth_hash][:instance_url]

      puts '<<<<<<<<<<<<<<<<<<<<<<< INSTANCE URL >>>>>>>>>>>>>>>>>>>>>'
      puts instUrl
      
      client.authenticate :token => session[:auth_hash][:token], :instance_url => instUrl, :refresh_token =>session[:auth_hash][:refresh_token]
      session[:client] = client
      flash[:success] = "Welcome #{env['omniauth.auth']['info']['name']}!"
      redirect_back_or profile_path
    else
      flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '. The service did not return valid data.'
      redirect_to home_path
    end

    return

  end

  def fail
    flash[:error] = "Oops, there was an error in the authentaction process."
    redirect_to root_path
  end
  
  def destroy
    sign_out
  end

end