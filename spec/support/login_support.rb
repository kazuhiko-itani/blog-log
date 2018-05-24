module LoginSupport
  def login_as(user)
    page.set_rack_session(user_id: user.id)
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end