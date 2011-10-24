# RSpec Deep Matchers

This gem adds a custom matcher to RSpec to recursively compare nested Ruby
data-structures consisting of `Hash` and `Array` elements.

## Example Usage

```ruby
describe "deep matchers usage" do
  it "should compare data-structures recursively" do
    expected = {:key => ["values", "are", ["good"]]}

    get :get_expected_json

    body = JSON.parse(response.body)
    body.should deep_eql expected
  end
end
```
