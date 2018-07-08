<template>
  <table class="vue-timetable vue-timetable-month-mode" id="timetable-2" v-if="date.list.length > 0">
    <thead>
      <tr>
        <slot name="header" :days="date.days">
          <th v-for="i in date.days">
            {{ moment().isoWeekday(i).format('dddd') }}
          </th>
        </slot>
      </tr>
    </thead>
    <tbody>
      <tr v-for="row in 6">
        <td v-for="col in 7">
          <div v-if="getCellData(row, col) !== null" :class="(moment().isSame(getCellData(row, col).date, 'day') ? 'vue-timetable-now' : '')">
            <span class="vue-timetable-day">{{ getCellData(row, col).date | moment('D') }}</span>
            <div v-for="event in getCellData(row, col).events" class="vue-timetable-event">
              <slot :event="event">
                <span class="vue-timetable-event-color" :style="{ backgroundColor: event.color }"></span>
                <span class="vue-timetable-event-link">
                  <span class="vue-timetable-event-time">{{ event.date.from | moment('HH:mm') }} - {{ event.date.to | moment('HH:mm') }}</span><br />
                  <span class="vue-timetable-event-name">{{ event.text }}</span>
                </span>
              </slot>
            </div>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
  import moment from 'moment'

  export default {
    name: 'month-timetable',
    props: ['month', 'events'],
    data () {
      let firstDayOfWeek = moment().isoWeekday() - moment().weekday()

      return {
        date: {
          month: typeof this.month === 'undefined' ? moment() : moment(this.month),
          days: firstDayOfWeek === 0 ? [0, 1, 2, 3, 4, 5, 6] : [1, 2, 3, 4, 5, 6, 0],
          firstDayOfWeek,
          list: []
        }
      }
    },
    methods: {
      moment () {
        return moment()
      },
      getCellData (row, col) {
        let cellId = (row - 1) * 7 + col - (1 - this.date.firstDayOfWeek)
        let dayId = cellId - moment(this.date.list[0].date).day()
        return dayId in this.date.list ? this.date.list[dayId] : null
      },
      fillDaysList () {
        this.date.list = []

        let now = this.date.month.clone().startOf('month')
        let to = this.date.month.clone().endOf('month')

        while (now.isBefore(to) || now.isSame(to)) {
          this.date.list.push({
            date: now.format(),
            events: this.getDayEvents(now)
          })
          now.add(1, 'days')
        }
      },
      getDayEvents (day) {
        if (typeof this.events === 'undefined') {
          return []
        }

        return this.events.filter((event) => {
          return day.isSame(event.date.from, 'day')
        }).sort((a, b) => {
          return moment(b.date.from).isBefore(a.date.from)
        })
      }
    },
    watch: {
      events () {
        // Fill the days events if the events data changes
        this.fillDaysList()
      },
      month () {
        this.date.month = moment(this.month)
        this.fillDaysList()
      }
    },
    created () {
      // Fill the days events on the component creation
      this.fillDaysList()
    }
  }
</script>
