require 'models'

RSpec.describe "ActiveRecord::Base subclass with #acts_as" do
  before { initialize_schema }
  
  context 'create' do
    let(:user) { create(:user, slug: 'username') }
    context 'without existing actable' do
      it 'creates a new actable object' do
        expect(user.acting_as).to be
        expect(user.acting_as).to be_a(Person)
        expect(user.acting_as.slug).to eq('username')
      end
    end
    context 'with existing actable' do
      before { @person = create(:person, slug: 'username') }
      it 'creates a new actable object' do
        expect(user.acting_as).to be
        expect(user.acting_as).to be_a(Person)
        expect(user.acting_as.slug).to eq('username')
        expect(user.acting_as).not_to eq(@person)
      end
    end
  end

  context 'destroy' do
    before do
      @user = create(:user, slug: 'username')
      @person = @user.acting_as
      @user.destroy
    end

    it 'destroys the actable object' do
      expect(@user).to be_destroyed
      expect(@person).to be_destroyed
    end
  end

  context 'update' do
    before do
      @user = create(:user, slug: 'username')
      @person = @user.acting_as
      @user.update_attributes(slug: 'newname')
    end

    it 'changes the actable object' do
      expect(@user.slug).to eq('newname')
      expect(@person.slug).to eq('newname')
    end
  end
end
