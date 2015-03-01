UserProfileManager::App.controllers :user do
  
  get :user, :map => '/user' do
    logger.info "GET /user request: #{params.inspect}"
    if params[:phone].nil?
      logger.error "GET /user Invalid parameters: #{params.inspect}"
      return [400]
    end
    begin
      user = User.where(phone: params[:phone]).take!
    rescue ActiveRecord::RecordNotFound => e
      logger.error "GET /user user not found with params #{params.inspect} #{e.inspect} #{e.backtrace}"
      return [404]
    rescue Exception => e
      logger.error "GET /user Couldn't fetch user for params #{params.inspect} #{e.inspect} #{e.backtrace}"
      return [422, {:reason => e.message, :text => 'Oops! Something went wrong!'}.to_json]
    end
    return [200, user.to_json]
  end

  post :user, :map => '/user' do
    logger.info "POST /user request: #{params.inspect}"
    if params[:phone].nil? or params[:public_name].nil?
      logger.error "POST /user Invalid parameters: #{params.inspect}"
      return [400]
    end
    if !UserProfileManager::App::PhoneHelper.is_valid?(params[:phone])
      logger.error "POST /user Invalid phone number: #{params.inspect}"
      return [400, {:reason => "Invalid phone number #{params[:phone]}", :text => "Invalid phone number #{params[:phone]}"}.to_json]
    end
    begin
      user = User.new(phone: params[:phone], public_name: params[:public_name])
      user[:first_name] = params[:first_name] if !params[:first_name].nil?
      user[:last_name] = params[:last_name] if !params[:last_name].nil?
      user[:locality] = params[:locality] if !params[:locality].nil?
      user[:city] = params[:city] if !params[:city].nil?
      user[:country] = params[:country] if !params[:country].nil?
      user[:postal_code] = params[:postal_code] if !params[:postal_code].nil?
      user[:email] = params[:email] if !params[:email].nil?
      user[:status] = User::STATUS_NEW
      user.save!
    rescue ActiveRecord::RecordInvalid => e
      logger.error "GET /user Invalid parameters params #{params.inspect} #{e.inspect} #{e.backtrace}"
      return [400]
    rescue ActiveRecord::RecordNotUnique => e
      logger.error "GET /user User already exists #{params.inspect} #{e.inspect} #{e.backtrace}"
      return [409, {:reason => "User already exists for phone: #{params[:phone]}", :text => "User already exists for phone: #{params[:phone]}"}.to_json]
    rescue Exception => e
      logger.error "GET /user Couldn't create user for params #{params.inspect} #{e.inspect} #{e.backtrace}"
      return [422, {:reason => e.message, :text => 'Oops! Something went wrong!'}.to_json]
    end
    return [201, user.to_json]
  end
end
