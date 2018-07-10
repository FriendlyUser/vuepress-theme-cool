import Vuex from 'vuex'
//import './timetableStyles.css'
import moment from 'vue-moment'
//import timetable from 'vue-timetable'
//Vue.use(timetable)
import ProgressBar from './progressbar.vue'

export default ({ Vue, options, router, siteData }) => {
    Vue.use(moment)
    Vue.use(Vuex)
    Vue.use(ProgressBar)
    Vue.mixin({
        computed: {
            $title() {
                const page = this.$page
                const siteTitle = this.$siteTitle
                const selfTitle = page.frontmatter.home ? null : (
                    page.frontmatter.title || // explicit title
                    (page.title ? page.title.replace(/[_`]/g, '') : '') // inferred title
                )
                return siteTitle
                    ? selfTitle
                        ? (selfTitle + ' | ' + siteTitle)
                        : siteTitle
                    : selfTitle || 'VuePress'
            }
        }
    })
}
