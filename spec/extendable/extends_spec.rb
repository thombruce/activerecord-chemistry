require 'models'

RSpec.describe "ActiveRecord::Base subclass with #extends" do
  before { initialize_schema }

  context 'new' do
    let(:confirmable) { create(:confirmable) }
    it 'is valid with valid attributes for extendable' do
      expect(confirmable).to be_valid
    end

    it 'is not valid with invalid extendable attributes' do
      confirmable.address = 2
      expect(confirmable).to_not be_valid
    end
  end

  context 'create' do
    let(:confirmable) { create(:confirmable, address: 'test@email.com') }
    context 'without existing extendable' do
      it 'creates a new extendable object' do
        expect(confirmable.extendable).to be
        expect(confirmable.extendable).to be_a(Email)
        expect(confirmable.extendable.address).to eq('test@email.com')
      end
    end
    context 'with existing extendable' do
      before { @email = create(:email, address: 'test@email.com') }
      it 'creates a new extendable object' do
        expect(confirmable.extendable).to be
        expect(confirmable.extendable).to be_a(Email)
        expect(confirmable.extendable.address).to eq('test@email.com')
        expect(confirmable.extendable).not_to eq(@email)
      end
    end
  end

  context 'destroy' do
    before do
      @confirmable = create(:confirmable, address: 'test@email.com')
      @email = @confirmable.extendable
      @confirmable.destroy
    end

    it 'does not destroy the extendable object' do
      expect(@confirmable).to be_destroyed
      expect(@email).to_not be_destroyed
    end
  end

  context 'update' do
    before do
      @confirmable = create(:confirmable, address: 'test@email.com')
      @email = @confirmable.extendable
      @confirmable.update_attributes(address: 'newname')
    end

    it 'changes the extendable object' do
      expect(@confirmable.address).to eq('newname')
      expect(@email.address).to eq('newname')
    end
  end
end
