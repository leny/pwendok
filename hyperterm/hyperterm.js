module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 12,

    // font family with optional fallbacks
    fontFamily: '"Fura Mono for Powerline", "Fira Mono OT", Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',

    // terminal cursor background color (hex)
    cursorColor: '#d6d6d6',

    // color of the text
    foregroundColor: '#d6d6d6',

    // terminal background color
    backgroundColor: '#2b2b2b',

    // border color (window, tabs)
    borderColor: '#444',

    // custom css to embed in the main window
    css: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    termCSS: '',

    // custom padding
    padding: '12px 14px',

    // some color overrides. see http://bit.ly/29k1iU2 for
    // the full list
    colors: [
      '#000000',
      '#f78d8c', // '#ff0000',
      '#a8d4a9', // '#33ff00',
      '#ffd479', // '#ffff00',
      '#78aad6', // '#0066ff',
      '#d7acd6', // '#cc00ff',
      '#76d4d6', // '#00ffff',
      '#ffffff',
      '#000000',
      '#f78d8c', // '#ff0000',
      '#a8d4a9', // '#33ff00',
      '#ffd479', // '#ffff00',
      '#78aad6', // '#0066ff',
      '#d7acd6', // '#cc00ff',
      '#76d4d6', // '#00ffff',
      '#ffffff'
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
