require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations check' do
    it { should validate_presence_of :body }
  end    
end
