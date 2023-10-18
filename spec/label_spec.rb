require_relative '../classes/label'

describe Label do
  let(:label_data) do
    {
      id: 456,
      title: 'Label Title',
      color: 'Label Color',
      items: [] # Include an empty array for the items
    }
  end

  it 'can be converted to hash' do
    label = Label.new(**label_data)
    label_hash = label.to_h
    expect(label_hash).to eq(label_data)
  end
end
