module Sessions
  class NewForm
    include ::ActiveModel::Model

    attr_accessor :uid, :password

    validates :uid, presence: true
    validates :password, presence: true
  end
end
