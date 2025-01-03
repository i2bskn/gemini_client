# GeminiClient

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/gemini_client`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add gemini_client

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install gemini_client

## Usage

```
client = GeminiClient.new(api_key: GEMINI_API_KEY)
payload = {
  contents: [
    {
      "role": "user",
      "parts": [
        {
          "text": "hello"
        }
      ]
    }
  ]
}
res = client.generate_content(payload: payload)
data = JSON.parse(res.body)
pp data
```

```
{"candidates"=>[{"content"=>{"parts"=>[{"text"=>"Hello there! How can I help you today?\n"}], "role"=>"model"}, "finishReason"=>"STOP", "avgLogprobs"=>-0.0006325314752757549}],
 "usageMetadata"=>{"promptTokenCount"=>2, "candidatesTokenCount"=>11, "totalTokenCount"=>13},
 "modelVersion"=>"gemini-1.5-flash"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/i2bskn/gemini_client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
