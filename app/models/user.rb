class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  # Associations
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id', dependent: :destroy
 
  validates :name, presence: true

  after_create :send_welcome_email


  def name_or_mail
    self.name? ? name : email
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
  
  
end

