module.exports = {
  config: {
    fontSize: 12, // default font size in pixels for all tabs
    fontFamily: '"Fira Mono OT", Menlo, "DejaVu Sans Mono", "Lucida Console", monospace', // font family with optional fallbacks
    cursorColor: '#999999', // terminal cursor background color (hex)
    foregroundColor: '#cccccc', // color of the text
    backgroundColor: '#2b2b2b', // terminal background color
    borderColor: '#393939', // border color (window, tabs)
    css: '', // custom css to embed in the main window
    termCSS: '', // custom padding (css format, i.e.: `top right bottom left`)
    padding: '12px 14px', // custom padding
    colors: [ // some color overrides. see http://bit.ly/29k1iU2 for the full list
      "#393939", // '#000000', // black
      "#f2777a", // '#ff0000', // red
      "#99cc99", // '#33ff00', // green
      "#ffcc66", // '#ffff00', // yellow
      "#6699cc", // '#0066ff', // blue
      "#cc99cc", // '#cc00ff', // magenta
      "#66cccc", // '#00ffff', // cyan
      "#cccccc", // white
      "#393939", // '#000000', // black
      "#f2777a", // '#ff0000', // red
      "#99cc99", // '#33ff00', // green
      "#ffcc66", // '#ffff00', // yellow
      "#6699cc", // '#0066ff', // blue
      "#cc99cc", // '#cc00ff', // magenta
      "#66cccc", // '#00ffff', // cyan
      "#cccccc", // white
      "#cccccc" // white
    ]
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hypersolar`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [],

  // in development, you can create a directory under
  // `~/.hyperterm_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
};
