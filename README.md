 [![Build Status](https://travis-ci.com/FriendlyUser/vuepress-theme-cool.svg?branch=master)](https://travis-ci.com/FriendlyUser/vuepress-theme-cool) [![npm version](https://badge.fury.io/js/vuepress-theme-cool.svg)](https://badge.fury.io/js/vuepress-theme-cool) [![downloads](https://img.shields.io/npm/dy/vuepress-theme-cool.svg)](https://www.npmjs.com/package/vuepress-theme-cool) [![](https://img.shields.io/badge/Protected_by-Hound-a873d1.svg)](https://houndci.com)
# Personal Documentation Theme for VuePress

Currently, completely refactoring code for vuepress v1, all components should be compatible.

This is the [VuePress](https://vuepress.vuejs.org/) theme used for personal documentation. It has libaries for markdown-based diagramming tools, sortable/filterable table components and chartjs.

An example repo is available at [Vuepress Theme Cool Starter](https://FriendlyUser.github.io/vuepress-theme-cool-starter)

[Demo](http://friendlyuser.github.io/vuepress-theme-cool-starter)

## Setup For Vuepress V1

 1. The theme was refactored completely to inherit from the base vuepress theme.
    Make sure to install the V1 for vuepress `yarn install --global vuepress@next`
 
 2. Get the latest version of the theme
    ```js
    yarn install -D vuepress-theme-cool
    ```
  
  3. Set up `.vuepress/config.js`. A minimual setup is below, note that mermaid does not need to be included as a plugin.

    ```js
    // .vuepress/config.js
    // this represents the minimal configuration
    module.exports = {
      theme: 'cool',
      markdown: {
        extendMarkdown: md => {
          md.set({ html: true })
          md.use(require('markdown-it-katex'))
          md.use(require('markdown-it-plantuml'))
          md.use(require('markdown-it-admonition'))
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
├──── index.styl
├──── palette.styl
├── Readme.md 
├──Readme.md
├── foo
├──── README.md
├──── doc1.md
└── cool
├──── doc2.md
```

If any issues arise, please review the documentation at https://v1.vuepress.vuejs.org/miscellaneous/migration-guide.html. The sample diagrams are components should work as it.

## Setup For Vuepress V0
See [VuepressV0](https://github.com/FriendlyUser/vuepress-theme-cool/blob/master/VuepressV0.md)

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

Katex can be created within a markdown file by, note that the necessary style sheet for `markdown-it-katex` is included in Layout.vue
`<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.5.1/katex.min.css">`.
```md
$x^2=4$
```

#### Rendering Charts 

Using chartjs and [vue-chartkick](https://github.com/ankane/vue-chartkick), allows for easy chart rendering from inside markdown files. What is good about vue-chartkick is highlightjs and google charts can be used instead.


For example the snippet below generates a pie chart, see chartjs for more details.
```js
<pie-chart :data="[['Blueberry', 44], ['Strawberry', 23]]" :download="true" download="test"></pie-chart>
```

#### Sortable and Filterable tables

For sortable and filterable tables, I am using the [vue-good-table](https://xaksis.github.io/vue-good-table/guide/#installation) which has documentation in vuepress. In order to generate tables, use an vue component under `.vuepress/components`

```js
//.vuepress/components/my-component.vue
<template>
  <div>
    <vue-good-table
      :columns="columns"
      :rows="rows"
     />
  </div>
</template>

<script>
import { VueGoodTable } from 'vue-good-table';

export default {
  name: 'my-component',
  // add to component
  components: { VueGoodTable},
  data(){
    return {
      columns: [
        {
          label: 'Name',
          field: 'name',
        },
        {
          label: 'Age',
          field: 'age',
          type: 'number',
        },
        {
          label: 'Created On',
          field: 'createdAt',
          type: 'date',
          dateInputFormat: 'YYYY-MM-DD',
          dateOutputFormat: 'MMM Do YY',
        },
        {
          label: 'Percent',
          field: 'score',
          type: 'percentage',
        },
      ],
      rows: [
        { id:1, name:"John", age: 20, createdAt: '201-10-31:9: 35 am',score: 0.03343 },
        { id:2, name:"Jane", age: 24, createdAt: '2011-10-31', score: 0.03343 },
        { id:3, name:"Susan", age: 16, createdAt: '2011-10-30', score: 0.03343 },
        { id:4, name:"Chris", age: 55, createdAt: '2011-10-11', score: 0.03343 },
        { id:5, name:"Dan", age: 40, createdAt: '2011-10-21', score: 0.03343 },
        { id:6, name:"John", age: 20, createdAt: '2011-10-31', score: 0.03343 },
      ],
    };
  },
};
</script>
```

In addition, use an custom style component to get the css classes for the production build.

```vue
//.vuepress/components/Styles.vue
<script>
import "vue-good-table/dist/vue-good-table.css";

export default {
  name: "Styles",
};
</script>

<style>
</style>
```
Render the table by placing `<my-component />`in a markdown file.
 
### Disclaimer

If you see any bugs feel free to make a pull request at Github or email me. Not a expert in vuepress at all or vue so there are ways to improve my implementations. In addition, some of the components do not work, do not hesitate to message me.
