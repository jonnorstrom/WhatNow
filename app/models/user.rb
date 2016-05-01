class User < ActiveRecord::Base
  validates :username, uniqueness: true
  validates :username, :password_hash, :zip, { presence: true }

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password_string)
    self.password == password_string
  end

  def find_coords
    CSV.foreach('./zipcode.csv', :headers => true) do |row|
      if row[0] == self.zip.to_s
        user_coords = {
        :lat => row[1].to_i,
        :lng => row[2].to_i,
        }
        return user_coords
      end
    end
  end
end
