module Api
  module V1
    class AuthController < ApplicationController  
      #http_basic_authenticate_with name:ENV["API_AUTH_NAME"], password:ENV["API_AUTH_PASSWORD"], :only => [:signup, :signin, :get_token]  
      before_filter :get_required_data
      before_filter :check_for_valid_authtoken, :except => [:signup, :signin, :get_token]
      
      def signup
        if request.post?
          if params && params[:full_name] && params[:email] && params[:password]
            
            params[:user] = Hash.new
            params[:user][:first_name] = params[:full_name].split(" ").first
            params[:user][:last_name] = params[:full_name].split(" ").last
            params[:user][:email] = params[:email]
            
            #begin 
            #  decrypted_pass = AESCrypt.decrypt(params[:password], ENV["API_AUTH_PASSWORD"])
            #rescue Exception => e
            #  decrypted_pass = nil          
            #end
                    
            params[:user][:password] = params[:password] 
            params[:user][:verification_code] = rand_string(20)
            
            user = Core::User.new(params[:user])

            puts params[:user]

            if user.save
              render :json => user.to_json, :status => 200, :message => "Registered"
            else
              e = Core::Error.new(:status => 200, :message => "Registered")
              render :json => e.to_json, :status => 200
              #render :json => user.errors.to_json, :status => 400, :message => "ERROR"
            end
          else
            e = Core::Error.new(:status => 400, :message => "required parameters are missing")
            render :json => e.to_json, :status => 400
          end
        end
      end

      def signin
        if request.post?
          if params && params[:email] && params[:password]        
            user = Core::User.where(:email => params[:email]).first
                          
            if user 
              if Core::User.authenticate(params[:email], params[:password]) 
                        
                if !user.api_authtoken || (user.api_authtoken && user.authtoken_expiry < Time.now)
                  auth_token = rand_string(20)
                  auth_expiry = Time.now + (24*60*60)
              
                  user.update_attributes(:api_authtoken => auth_token, :authtoken_expiry => auth_expiry)    
                end 
                                       
                render :json => user.to_json, :status => 200
              else
                e = Core::Error.new(:status => 401, :message => "Wrong Password")
                render :json => e.to_json, :status => 401
              end      
            else
              e = Core::Error.new(:status => 400, :message => "No USER found by this email ID")
              render :json => e.to_json, :status => 400
            end
          else
            e = Core::Error.new(:status => 400, :message => "required parameters are missing")
            render :json => e.to_json, :status => 400
          end
        end
      end
      
      def reset_password
        if request.post?
          if params && params[:old_password] && params[:new_password]         
            if @user         
              if @user.authtoken_expiry > Time.now
                authenticate_user = Core::User.authenticate(@user.email, params[:old_password])
                            
                if authenticate_user && !authenticate_user.nil?             
                  auth_token = rand_string(20)
                  auth_expiry = Time.now + (24*60*60)
                
                  new_password = params[:new_password]
                  #begin
                  #  new_password = AESCrypt.decrypt(params[:new_password], ENV["API_AUTH_PASSWORD"])  
                  #rescue Exception => e
                  #  new_password = nil
                  #  puts "error - #{e.message}"
                  #end
                  
                  new_password_salt = BCrypt::Engine.generate_salt
                  new_password_digest = BCrypt::Engine.hash_secret(new_password, new_password_salt)
                                  
                  @user.update_attributes(:password => new_password, :api_authtoken => auth_token, :authtoken_expiry => auth_expiry, :password_salt => new_password_salt, :password_hash => new_password_digest)
                  render :json => @user.to_json, :status => 200           
                else
                  e = Core::Error.new(:status => 401, :message => "Wrong Password")
                  render :json => e.to_json, :status => 401
                end
              else
                e = Core::Error.new(:status => 401, :message => "Authtoken is invalid or has expired. Kindly refresh the token and try again!")
                render :json => e.to_json, :status => 401
              end
            else
              e = Core::Error.new(:status => 400, :message => "No user record found for this email ID")
              render :json => e.to_json, :status => 400
            end
          else
            e = Core::Error.new(:status => 400, :message => "required parameters are missing")
            render :json => e.to_json, :status => 400
          end
        end
      end
      
      def get_token
        if params && params[:email]    
          user = Core::User.where(:email => params[:email]).first
        
          if user 
            if !user.api_authtoken || (user.api_authtoken && user.authtoken_expiry < Time.now)          
              auth_token = rand_string(20)
              auth_expiry = Time.now + (24*60*60)
              
              user.update_attributes(:api_authtoken => auth_token, :authtoken_expiry => auth_expiry)                              
            end        
            
            render :json => user.to_json(:only => [:api_authtoken, :authtoken_expiry])                
          else
            e = Core::Error.new(:status => 400, :message => "No user record found for this email ID")
            render :json => e.to_json, :status => 400
          end
          
        else
          e = Core::Error.new(:status => 400, :message => "required parameters are missing")
          render :json => e.to_json, :status => 400
        end
      end

      def clear_token
        if @user.api_authtoken && @user.authtoken_expiry > Time.now
          @user.update_attributes(:api_authtoken => nil, :authtoken_expiry => nil)
              
          m = Core::Message.new(:status => 200, :message => "Token cleared")          
          render :json => m.to_json, :status => 200  
        else
          e = Core::Error.new(:status => 401, :message => "You don't have permission to do this task")
          render :json => e.to_json, :status => 401
        end 
      end

      private 
      
      def check_for_valid_authtoken
        authenticate_or_request_with_http_token do |token, options|  

          puts token   
          @user = Core::User.where(:api_authtoken => token).first      
        end
      end
      
      def rand_string(len)
        o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
        string  =  (0..len).map{ o[rand(o.length)]  }.join

        return string
      end

      def get_required_data

          @mdl = nil
          @jdata = nil
          @member_id = request.headers['MEMBERID'].to_s
          @app_id = request.headers['APPID'].to_s

          if @member_id == nil or @app_id == nil
            respond_with :status => 400
            return
          end

          @member = Core::Member.find(@member_id)
          if @member == nil 
            respond_with :status => 401
            return
          end

          Thread.current[:member] = @member_id
          @app = Core::App.find(@app_id)
          if @app == nil 
            respond_with :status => 402
            return
          end

        end
    end 
  end
end