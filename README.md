# Personal Documentation Theme for VuePress

This is the [VuePress](https://vuepress.vuejs.org/) theme used for my fourth year engineering courses.

## Setup

1. [Install](https://vuepress.vuejs.org/guide/getting-started.html) VuePress like normal
2. Require this theme

    ```js
    yarn add -D vuepress-cooltheme
    ```

3. Set up `.vuepress/config.js`. A minimual setup is below, note that mermaid does not need to be included as a plugin.
    ```js
    // .vuepress/config.js
    module.exports = {
      theme: 'cool',
      markdown: {
        // options for markdown-it-anchor
        anchor: { permalink: true },
        // options for markdown-it-toc
        toc: { includeLevel: [1, 2,3, 4] },
        config: md => {
          // use more markdown-it plugins!
          md.use(require("markdown-it-katex"));
          md.use(require("markdown-it-plantuml"))
        }
      }
    }
    ```
4. If you are adding vuepress to your local project, set up `package.json` and your file directory looks something like this

```sh
├ package.json
├ docs
├── .vuepress
├──── components
├──── public
├──── config.js
├──── override.styl
├── Readme.md 
├──Readme.md
├── foo
├──── README.md
├──── doc1.md
└── cool
├──── doc2.md
```

Also, make sure to include the scripts in package.json

```json
{
  "scripts": {
    "docs:dev": "vuepress dev docs",
    "docs:build": "vuepress build docs"
  }
}
```