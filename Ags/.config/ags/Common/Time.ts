const defaultLocale = "en-GB";

class DateTimeBuilder {
  s: string = "";
  dateObject: Date = new Date();
  locale: string;
  date?: string[];
  time?: string[];
  getFull: boolean = false;
  constructor({ locale = defaultLocale }) {
    this.locale = locale;
    this.Init();
  }
  private Init(): void {
    this.time = this.dateObject.toLocaleTimeString(this.locale).split(":", 3);
    this.date = this.dateObject
      .toLocaleDateString(this.locale, {
        weekday: "short",
        day: "numeric",
        month: "short",
        year: "numeric",
      })
      .split(" ", 4);
  }
  String(str: string = " "): DateTimeBuilder {
    this.s = this.s.concat(str);
    return this;
  }
  Second(): DateTimeBuilder {
    this.s = this.s.concat(this.time![3]);
    return this;
  }
  Minute(): DateTimeBuilder {
    this.s = this.s.concat(this.time![2]);
    return this;
  }
  Hour(): DateTimeBuilder {
    this.s = this.s.concat(this.time![1]);
    return this;
  }
  Time(): DateTimeBuilder {
    this.s = this.s.concat(this.time!.join(":"));
    return this;
  }
  Date(): DateTimeBuilder {
    this.s = this.s
      .concat(`${this.date![0]} `)
      .concat(`${this.date![1]} `)
      .concat(`${this.date![2]}. `)
      .concat(`${this.date![3]}`);
    return this;
  }
  Build(): string {
    return this.s;
  }
  Refresh(): DateTimeBuilder {
    this.s = "";
    this.dateObject = new Date();
    this.Init();
    return this;
  }
  ToggleFull() {
    this.getFull = !this.getFull;
  }
  Get() {
    return this.getFull
      ? this.Refresh().Time().String(" ").Date().Build()
      : this.Refresh().Time().Build();
  }
}

const TimeWidget = ({ class_name = "time-widget", locale = defaultLocale }) => {
  const dateTimeBuilder = new DateTimeBuilder({ locale });

  const Time = Variable("", {
    poll: [1000, () => dateTimeBuilder.Get()],
  });
  const timeLabel = Widget.Label({
    class_name: class_name,
    hpack: "center",
    label: Time.bind(),
  });

  return Widget.Button({
    on_primary_click: () => dateTimeBuilder.ToggleFull(),
    class_name: "time-widget",
    child: timeLabel,
  });
};

export default TimeWidget;
