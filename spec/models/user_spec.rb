# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  tokens                 :json
#  username               :string
#  picture                :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

require 'rails_helper'

describe User do
  describe 'validations' do
    subject { build :user }
    it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
    it { should validate_uniqueness_of(:username) }

    context 'when was created with regular login' do
      subject { build :user }
      # Pending test until https://github.com/lynndylanhurley/devise_token_auth/pull/865 is merged
      xit { should validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) }
      it { should validate_presence_of(:email) }
    end
  end
end
