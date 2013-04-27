require 'spec_helper'

describe User do
  it { should have_many(:attempts)}

  it { should respond_to(:email) }

  it { should validate_presence_of :email }
  it { should_not allow_value('yuckcity').for(:email) }
  it { should allow_value('yuck@city.com').for(:email) }
  it { should respond_to :authenticate }

  describe "email address with mixed case" do
    let(:user) {create(:user)}

    it "should be saved as all lower-case" do
      user.email = "Foo@BaR.CoM"
      user.save
      expect(user.reload.email).to  eq("Foo@BaR.CoM".downcase)
    end
  end

  context 'authenticate' do
    let(:user) {create(:user)}
    it 'should return a user object when given the correct username and password' do
      expect(user.authenticate('Winter_Is_Coming')).to  eq(user)
    end

    it 'should return false if the password is incorrect' do
      expect(user.authenticate('summer')).to  eq(false)
    end
  end

  describe 'answer_percent' do
    let(:user) {create(:user)}
    context 'when all attempts are correct' do
      it 'should be 100%' do
        3.times { create(:attempt, :correct, user_id: user.id) }
        expect(user.answer_percent).to eq(100)
      end
    end

    context 'when all attempts are incorrect' do
      it 'should be 0%' do
        3.times { create(:attempt, :incorrect, user_id: user.id) }
        expect(user.answer_percent).to eq(0)
      end
    end

    context 'when some answers are correct' do
      it 'should have the appropriate %' do
        2.times { create(:attempt, :incorrect, user_id: user.id)}
        3.times { create(:attempt, :correct, user_id: user.id)}
        expect(user.answer_percent).to eq(60)
      end
    end
  end
end

