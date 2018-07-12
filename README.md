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

or if you use `node_modules/vuepress/bin/vuepress`, instead of installing vuepress globally.

### Creating Diagrams
#### Plantuml
Plantuml can be used like 

```
@startuml
strict digraph meme {
  exists [color=blue]
  authenticate [color=blue]
  require
  create
  UserCreated
  destroy
  UserDestroyed
  get [color=blue]
  authenticate -> require
  create -> UserCreated
  destroy -> require
  destroy -> UserDestroyed
  get -> require
}
@enduml
```

#### Mermaid

In addition to use mermaid diagrams add an components, taken from [Vuepress Issue 111](https://github.com/vuejs/vuepress/issues/111), obviously I expect vuepress to natively support mermaid, or have tighter integration in the future.

```js
// .vuepress/components/mermaid.vue

<template>
  <div class="mermaid">
    <slot></slot>
  </div>
</template>

<script>
export default {
  mounted() {
    import("mermaid/dist/mermaid").then(m => {
      m.initialize({
        startOnLoad: true
      });
      m.init();
    });
  }
};
</script>
```


Mermaid components can be used like

```js
<mermaid>
graph TD
  A[Cool] -->|Get money| B(Go shopping)
  B --> C{Let me}
  C -->|Two| D[Laptop]
  C -->|Two| E[iPhone]
  C -->|Three| F[Car]
  C -->|Four| F[Mac]
</mermaid>
```

#### Timeline

```js
// .vuepress/components/sample-timeline.vue
<template>
  <timeline timeline-theme="lightblue">
    <timeline-title bg-color="#09FFAA">Road to Graduation</timeline-title>
    <timeline-item bg-color="#9dd8e0">First Year 1A</timeline-item>
    <timeline-item bg-color="#9dFFe0">First Year 1B</timeline-item>
    <timeline-item bg-color="#FFF000">Accepted Computer Engineering</timeline-item>
    <timeline-item bg-color="#cFe8eF">ENGR 1C (extra courses)</timeline-item>
    <timeline-item bg-color="#97Aec8">Second Year 2A</timeline-item>
    <timeline-item bg-color="#5744D4">ENGR 2.5</timeline-item>
    <timeline-item bg-color="#0F4859">Second Year 2B</timeline-item>
    <timeline-item bg-color="#094341">ENGR 001</timeline-item>
    <timeline-item bg-color="#825F03">ENGR 002</timeline-item>
    <timeline-item bg-color="#954F08">Third Year (3 classes)</timeline-item>
    <timeline-item bg-color="#A71490">Third Year 3B</timeline-item>
    <timeline-item bg-color="#C084A9">Third Year 3A</timeline-item>
    <timeline-item bg-color="#7B71C2">ENGR 003</timeline-item>
    <timeline-item bg-color="#2348B1">ENGR 004</timeline-item>
    <timeline-item bg-color="#915F15">Fourth Year 4B</timeline-item>
    <timeline-item bg-color="#0909FA">Fourth Year 4A</timeline-item>
  </timeline>
</template>
 
<script>
import { Timeline, TimelineItem, TimelineTitle } from 'vue-cute-timeline'
 
export default {
  components: {
    Timeline,
    TimelineItem,
    TimelineTitle
  }
}
</script>
```

and render it in the markdown file using `<sample-timeline />`.

#### Using math

Katex can be created within a markdown file by 

```md
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.5.1/katex.min.css">
$x^2=4$
```

#### Rendering Charts 

Using chartjs and [vue-chartkick](https://github.com/ankane/vue-chartkick), allows for easy chart rendering from inside markdown files. What is good about vue-chartkick is highlightjs and google charts can be used instead.


For example the snippet below generates a pie chart, see chartjs for more details.
```js
<pie-chart :data="[['Blueberry', 44], ['Strawberry', 23]]" :download="true" download="test"></pie-chart>
```


### Disclaimer

If you see any bugs feel free to make a pull request at Github or email me. Not a expert in vuepress at all or vue so there are ways to improve my implementations.