# PhotoTimeliner

Organize Pictures by date. Reading the Exif information this script help to sort your unorganized pictures.

<img width="425" alt="Screen Shot 2021-01-19 at 3 58 06 PM" src="https://user-images.githubusercontent.com/5789/105051613-390daf80-5a6f-11eb-99dc-1411b0b19d7d.png">

<img width="428" alt="Screen Shot 2021-01-19 at 3 58 17 PM" src="https://user-images.githubusercontent.com/5789/105051604-3743ec00-5a6f-11eb-9697-0ea831517ced.png">

The Exif information are used to sort the pictures, however, if those informations are not available the CTIME is used.

The name is change following those rules:

image-original-name.jpg => '%Y%m%d_%H%M%S-image-original-name.jpg

`PhotoTimeliner` can take care of your videos too! Just change the media type --media=video

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

Usage: bin/sort --no-verbose --source_directory='/Volumes/Ext/Source' --target_directory='/Volumes/Ext/Destination

Specific options:
    -s SOURCE_DIRECTORY,             [OPTIONAL] Where the pictures are
        --source_directory
    -t TARGET_DIRECTORY,             [OPTIONAL] Where the pictures will go
        --target_directory
    -n, --parallel PARALLEL          [OPTIONAL] How many threads
        --exif_strategy [EXIF_STRATEGY]
                                     Select the exif strategy (basic, virtual)
        --media [MEDIA]              Select the media type (image, video, system)
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
