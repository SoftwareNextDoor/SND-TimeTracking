module SessionsHelper
  
  def signed_in?
      !session[:auth_hash].nil?
  end

  def sign_out(sm = 0)
      instURL = ''
      if signed_in?
        instURL = session[:auth_hash][:instance_url]
      end
      
      redirect_to signoutsf_path(:orgurl => instURL,:sm => sm)
  end

  def signout_exp
    sign_out(1)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def authenticate
    deny_access unless signed_in?
  end

  def authenticateSF

    #set default values
    auth_params = nil
    provider = ENV['DEFAULT_PROVIDER']

    auth_params = {
      :display => 'touch',
      :immediate => 'false',
      :scope => 'full'
    }
    if provider == 'customurl'
      auth_params[:customurl] = ENV['DEFAULT_CUSTOM_URL']
    end

    #look for defined options
    if !params[:options].blank?
      provider = sanitize_provider(params[:options]['provider'])
      auth_params = {
        :display => params[:options]['display'],
        :immediate => params[:options]['immediate'],
        :scope => params[:options].to_a.flatten.keep_if{|v| v.start_with? "scope|"}.collect!{|v| v.sub(/scope\|/,"")}.join(" ")
      }
      if params[:options]['provider']=='customurl'
        auth_params[:customurl] = params[:options]['curl']
      end
    end

    auth_params = URI.escape(auth_params.collect{|k,v| "#{k}=#{v}"}.join('&'))
    redirect_to "/auth/#{provider}?#{auth_params}"
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
                      
  private
  
      def store_location
        session[:return_to] = request.fullpath
      end

      def clear_return_to
        session[:return_to] = nil
      end

      def sanitize_provider(provider = nil)
        provider.strip! unless provider == nil
        provider.downcase! unless provider == nil
        provider = "salesforce" unless %w(salesforcesandbox salesforceprerelease databasedotcom customurl).include? provider
        provider
      end

end