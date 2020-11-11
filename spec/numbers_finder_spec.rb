RSpec.describe NumbersFinder do
  it "has a version number" do
    expect(NumbersFinder::VERSION).not_to be nil
  end

  context 'extracts 2 max numbers (4 digits length max) from text stream' do
    subject { NumbersFinder }

    let(:max_numbers) { 2 }
    let(:max_number_len) { 4 }

    it 'when number of digits less than required' do
      numbers = subject.extract_maximum_numbers_from_string('text 666', max_numbers, max_number_len)
      expect(numbers).to eq([666])
    end

    it 'from empty string' do
      numbers = subject.extract_maximum_numbers_from_string('', max_numbers, max_number_len)
      expect(numbers).to eq([])
    end

    it 'from text not countaining digits' do
      numbers = subject.extract_maximum_numbers_from_string('text text text', max_numbers, max_number_len)
      expect(numbers).to eq([])
    end

    it 'when non-repeated numbers are glued' do
      numbers = subject.extract_maximum_numbers_from_string('text 88889999777 text', max_numbers, max_number_len)
      expect(numbers).to eq([8888, 9999])
    end

    it 'when repeated numbers are glued' do
      numbers = subject.extract_maximum_numbers_from_string('text 88889999777 text 777788889999 text', max_numbers, max_number_len)
      expect(numbers).to eq([8888, 9999])
    end

    it 'when non-repeated numbers are not glued' do
      numbers = subject.extract_maximum_numbers_from_string('text 1111 text 222 text 3333', max_numbers, max_number_len)
      expect(numbers).to eq([1111, 3333])
    end
  end
end

