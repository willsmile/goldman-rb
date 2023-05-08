# Goldman

Goldman is a tool for [g]enerating [o]ption [l]ist of sche[d]ule. And goldman-rb is its ruby
implementation.

## Requirements
- Ruby: MRI 3.0+

## Installation

Goldman's installation is standard for a Ruby gem:

```sh
gem install goldman
```

## Setup and configuration
Please create a configuration file (`*.yml`) and use the environment variable `GOLDMAN_RB_PATH` to set up the file's path.
If `GOLDMAN_RB_PATH` is not set, the tool will use the default file path `~/.goldman/config.yml`.

Please define the data of schedule options are described in `config.yml` as follows.
The available data keys are `everyday`, `weekday`, `weekend`, and the day of the week.

```yml:config.yml
data:
  Everyday:
    - "10:00~11:00"
  Weekday:
    - "12:00~13:00"
  Weekend:
    - "20:00~21:00"
  Monday: 
    - "16:00~17:00"
  Wednesday:
    - "16:00~17:00"
  Thursday:
    - "16:00~17:00"
```

You can customize the format to display each schedule option by setting them up in `config.yml`. If it is not customized, the tool uses the default one.

```yml:config.yml
format:
  schedule: "%{date}(%{wday}) %{time}"
  date: "%Y/%m/%d"
  wday:
    Monday: "月"
    Tuesday: "火"
    Wednesday: "水"
    Thursday: "木"
    Friday: "金"
    Saturday: "土"
    Sunday: "日"
```

## Usage
The start date will always be today if it is not specified.

```sh
# Generate schedule options in a week
goldman -g

# Generate schedule options starting from today (assume 2023-04-25) and ending to 2023-04-30
goldman -g -e 2023-04-30

# Generate schedule options starting from 2023-05-08 and ending to 2023-04-30
goldman -g -s 2023-05-08 -e 2023-05-12

# Generate schedule options in three weeks
goldman -g -w 3

# Generate schedule options in eight days
goldman -g -d 8
```

The example of generated schedule options is as follows.

```sh
❯ goldman -g -d 5
2023/04/25(Tue) 12:00~13:00
2023/04/26(Wed) 12:00~13:00
2023/04/26(Wed) 16:00~17:00
2023/04/27(Thu) 12:00~13:00
2023/04/27(Thu) 16:00~17:00
2023/04/28(Fri) 12:00~13:00
```
