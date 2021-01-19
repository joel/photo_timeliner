# PhotoTimeliner

Sort Pictures by date. Reading the Exif information this script help to sort your unorganized pictures.

<img width="242" alt="Screen Shot 2021-01-19 at 2 29 03 PM" src="https://user-images.githubusercontent.com/5789/105041701-9bf94980-5a63-11eb-9bfc-795ed678c8b2.png">

<img width="418" alt="Screen Shot 2021-01-19 at 2 29 37 PM" src="https://user-images.githubusercontent.com/5789/105041713-9e5ba380-5a63-11eb-9618-ced67d58c3f8.png">

## Installation

### Docker

```
git clone https://github.com/joel/photo_timeliner
```

```
cd photo_timeliner
```

```
docker build --tag photo:timeliner .
```

### Macos

```
git clone https://github.com/joel/photo_timeliner
```

```
cd photo_timeliner
```

```
bundle install
```

## Usage

### Docker

```
docker run --rm --name timeliner \
  --mount type=bind,source=(pwd),target=/workdir \
  --workdir /workdir \
  --mount "type=bind,source=/Volumes/My Backup Hard Disk,target=/workdir/unsorted" \
  --mount "type=bind,source=/Volumes/Other Hard Disk/Pictures,target=/workdir/sorted" \
-it photo:timeliner sh -c "sh /workdir/bin/sort --no-verbose --source_directory '/workdir/unsorted' --target_directory '/workdir/sorted' --parallel 32"
```

### Macos

```
cd photo_timeliner
```

```
bin/sort --help
```

```
bin/sort --help

Usage: bin/sort -s /Volume/Ext/Source -t /Volume/Ext/Destination --verbose

Specific options:
    -s SOURCE_DIRECTORY,             [OPTIONAL] Where the pictures are
        --source_directory
    -t TARGET_DIRECTORY,             [OPTIONAL] Where the pictures will go
        --target_directory
    -n, --parallel PARALLEL          [OPTIONAL] How many threads
        --exif_strategy [EXIF_STRATEGY]
                                     Select the exif strategy (basic, virtual)
    -v, --[no-]verbose               Run verbosely

Common options:
    -h, --help                       Show this message
        --version                    Show version
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/photo_timeliner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/photo_timeliner/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PhotoTimeliner project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/photo_timeliner/blob/master/CODE_OF_CONDUCT.md).
