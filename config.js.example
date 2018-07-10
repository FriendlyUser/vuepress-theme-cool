// .vuepress/config.js
module.exports = {
  themeConfig: {
    sidebar: 'auto',
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Guide', link: '/guide/' },
      { text: 'Smart Contracts', link: 'smart-contracts/'},
      { text: 'Blog', items: [
          { text: 'Group1', 
            items: [
                { text: 'Smart Contracts', link: 'smart-contracts/'},
                { text: 'Smart Contracts', link: 'smart-contracts/'},
            ] 
          },
          { text: 'Group2', 
            items: [
                { text: 'Smart Contracts', link: 'smart-contracts/'},
                { text: 'Smart Contracts', link: 'smart-contracts/'},
            ] 
          }
        ] 
      },
      { text: 'External', link: 'https://google.com' },
    ]
  },
  title: 'Hello VuePress',
  description: 'Just playing around',
  configureWebpack: {
    resolve: {
      alias: {
        '@alias': '../img'
      }
    }
  },
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
