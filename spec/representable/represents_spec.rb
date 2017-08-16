require 'models'

RSpec.describe "ActiveRecord::Base subclass with #represents" do
  before { initialize_schema }

  context 'new' do
    let(:display_name) { create(:display_name) }
    it 'is valid with valid attributes for representable' do
      expect(display_name).to be_valid
    end

    it 'is not valid with invalid representable attributes' do
      display_name.appellation = 2
      expect(display_name).to_not be_valid
    end
  end

  context 'create' do
    let(:display_name) { create(:display_name, appellation: 'John Doe') }
    context 'without existing representable' do
      it 'creates a new representable object' do
        expect(display_name.representing).to be
        expect(display_name.representing).to be_a(PersonalName)
        expect(display_name.representing.appellation).to eq('John Doe')
      end
    end
    context 'with existing representable' do
      before { @personal_name = create(:personal_name, appellation: 'John Doe') }
      it 'associates with existing representable object' do
        expect(display_name.representing).to be
        expect(display_name.representing).to be_a(PersonalName)
        expect(display_name.representing.appellation).to eq('John Doe')
        expect(display_name.representing).to eq(@personal_name)
      end
    end
  end

  context 'destroy' do
    before do
      @display_name = create(:display_name, appellation: 'John Doe')
      @personal_name = @display_name.representing
    end

    context 'with no other representatives' do
      before { @display_name.destroy }
      it 'destroys the representable object' do
        expect(@display_name).to be_destroyed
        expect(@personal_name).to be_destroyed
      end
    end

    context 'with other representatives' do
      before do
        create(:display_name, appellation: 'John Doe')
        @display_name.destroy
      end
      it 'does not destroy the representable object' do
        expect(@display_name).to be_destroyed
        expect(@personal_name).to_not be_destroyed
      end
    end
  end

  context 'update' do
    before do
      @display_name = create(:display_name, appellation: 'John Doe')
      @personal_name = @display_name.representing
    end

    context 'with no other representatives' do
      before { @display_name.update_attributes(appellation: 'Dave Jones') }
      it 'changes the representable object' do
        expect(@display_name.appellation).to eq('Dave Jones')
        expect(@personal_name.appellation).to eq('Dave Jones')
      end
    end

    context 'with other representatives' do
      before do
        create(:display_name, appellation: 'John Doe')
        @display_name.update_attributes(appellation: 'Dave Jones')
      end
      it 'does not change the representable object' do
        expect(@display_name.appellation).to eq('Dave Jones')
        @personal_name.reload
        expect(@personal_name.appellation).to_not eq('Dave Jones')
        expect(@personal_name.appellation).to eq('John Doe')
      end
    end
  end
end
