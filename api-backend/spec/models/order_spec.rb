require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:user) }
  
  it { should validate_presence_of(:yearly_price) }
  it { should validate_presence_of(:device) }
  it { should validate_presence_of(:imei) }
end
