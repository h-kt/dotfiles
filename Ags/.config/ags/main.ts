import Bar from "./Bar/Bar";
import NotificationPopups from "./Common/Notification"

App.config({
  style: "./style.css",
  windows: [
    Bar(0),
    NotificationPopups(),
  ],
});

Utils.monitorFile(
  // directory that contains the scss files
  `${App.configDir}`,

  // reload function
  function() {
    // main scss file
    const css = `${App.configDir}/style.css`

    App.resetCss()
    App.applyCss(css)
  },
)
