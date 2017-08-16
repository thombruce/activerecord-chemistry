require 'models'

RSpec.describe "ActiveRecord::Base subclass with #represents" do
  before { initialize_schema }
  
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
end
