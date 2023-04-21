require 'spec_helper'

describe 'parameter_types' do
  let(:msg) { 'missing datatype for parameter spec::%s' }

  %w[class define].each do |rt|
    context "#{rt} without parameters" do
      let(:code) { 'class spec() {}' }

      it 'is not a problem' do
        expect(problems).to have(0).problem
      end
    end

    context "simple #{rt} without type" do
      let(:code) { 'class spec($foo) { }' }

      it 'is a problem' do
        expect(problems).to have(1).problem
        expect(problems).to contain_warning(msg % :foo).on_line(1)
      end
    end

    context "#{rt} with many params without type" do
      let(:code) do
        <<~EOL
          class spec (
            $attr1,
            $attr2,
            $attr3
          ) { }
        EOL
      end

      it 'is a problem' do
        expect(problems).to have(3).problem
      end
    end

    context "#{rt} with many params without type on one line" do
      let(:code) { 'class spec ($attr1, $attr2, $attr3 ) { }' }

      it 'is a problem' do
        expect(problems).to have(3).problem
      end
    end

    context "#{rt} with many params and defaults without type" do
      let(:code) do
        <<~EOL
          class spec (
            $attr0,
            $attr1 = 1,
            $attr2 = $attr1,
            $attr3 = [ 'array', 'with', 'entries'],
            $attr4 = { 'key' => 'value' }
            $attr5 = {
              'key' => 'value',
              'key2' => [
                'val1',
                'val2',
              ],
           },
          ) { }
        EOL
      end

      it 'is a problem' do
        expect(problems).to have(5).problem
      end
    end

    context "#{rt} with some attributes typed" do
      let(:code) do
        <<~EOL
          class spec (
            Integer $attr1,
            String  $attr2 = 'foo',
            $attr3 = undef,
            $attr4 = { 'key' => 'value' }
            Array[Struct[{
              name       => String[1],
              source_url => String[1],
              delete     => Optional[Boolean],
              exclude    => Optional[Variant[String,Array[String]]],
              include    => Optional[Variant[String,Array[String]]],
              sync_hour  => Optional[String],
            }]]             $repos = [],
            Hash $attr5 = {
              'key' => 'value',
              'key2' => [
                'val1',
                'val2',
              ],
           },
          ) { }
        EOL
      end

      it 'is a problem' do
        expect(problems).to have(2).problem
      end
    end

    context "#{rt} with some attributes typed on one line" do
      let(:code) { 'class spec(Integer $attr1, $attr2 = 5, Variant[String,Integer] $attr 3, $attr4 = [1,2]) { }' }

      it 'is a problem' do
        expect(problems).to have(2).problem
      end
    end

    context "#{rt} with all attributes typed" do
      let(:code) do
        <<~EOL
          class spec (
            Integer $attr1,
            String  $attr2 = 'foo',
            Optional[String] $attr3 = undef,
            Optional[Variant[Integer,Array[String] $attr4 = undef,
            Stdlib::MyType $attr5 = undef,
          ) { }
        EOL
      end

      it 'is not a problem' do
        expect(problems).to have(0).problem
      end
    end

    context "#{rt} with all attributes typed complex" do
      let(:code) do
        <<~EOL
          class spec (
            Integer $attr1,
            String  $attr2 = 'foo',
            Optional[String] $attr3 = undef,
            Optional[Variant[Integer,Array[String] $attr4,
            Array[Struct[{
              name       => String[1],
              source_url => String[1],
              delete     => Optional[Boolean],
              exclude    => Optional[Variant[String,Array[String]]],
              include    => Optional[Variant[String,Array[String]]],
              sync_hour  => Optional[String],
            }]]             $repos = [],
          ) { }
        EOL
      end

      it 'is not a problem' do
        expect(problems).to have(0).problem
      end
    end
  end
end
