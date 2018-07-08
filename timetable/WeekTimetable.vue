<template>
  <div>
    <div class="vue-timetable vue-timetable-week-mode" data-view="week" id="timetable-3">
      <div class="vue-timetable-hours">
        <div class="vue-timetable-hour" v-for="i in (date.hours.end - (date.hours.start -1))" :style="{ height: height + 'px' }">
          <span>{{ i + (date.hours.start - 1) }}:00</span>
        </div>
      </div>
      <div class="vue-timetable-content">
        <div class="vue-timetable-columns">
          <div class="vue-timetable-column" v-for="day in date.list">
            <slot name="header" :day="day">
              <div class="vue-timetable-column-header">
                {{ day.date | moment("dddd") }}<br>
                <span>{{ day.date | moment("DD/MM/YYYY") }}</span>
              </div>
            </slot>
            <div class="vue-timetable-column-content">
              <span class="vue-timetable-event" v-for="event in day.events" :style="{ top: event.placement.top + 'px', height: event.placement.height + 'px', backgroundColor: event.color }">
                <slot :event="event">
                  <span>{{ event.text }}</span>
                </slot>
              </span>
            </div>
            <div class="vue-timetable-column-grid">
              <div :style="{ height: (height - 1) + 'px'}" class="vue-timetable-grid-item"
                   v-for="i in (date.hours.end - date.hours.start)"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div style="clear: both"></div>
  </div>
</template>

<script>
  import moment from 'moment'

  export default {
    name: 'week-timetable',
    props: ['week', 'events', 'hour-range', 'day-range', 'cell-height'],
    data () {
      return {
        height: this.cellHeight ? this.cellHeight : 50,
        date: {
          week: this.week ? moment(this.week) : moment().weekday(0),
          hours: this.hourRange ? this.hourRange : {start: 8, end: 20},
          days: this.dayRange ? this.dayRange : [1, 2, 3, 4, 5, 6, 7],
          list: []
        }
      }
    },
    mounted () {

    },
    methods: {
      moment () {
        return moment()
      },
      fillDaysList () {
        this.date.list = []

        let now = this.date.week.clone()

        while (now.week() === this.date.week.week()) {
          if (this.date.days.indexOf(now.isoWeekday()) !== -1) {
            this.date.list.push({
              date: now.format(),
              events: this.getDayEvents(now)
            })
          }
          now.add(1, 'days')
        }
      },
      getDayEvents (day) {
        let self = this

        if (typeof this.events === 'undefined') {
          return []
        }

        return this.events.map(event => {
          event.placement = {
            top: ((event.date.from.hour() * 60 + event.date.from.minute()) - self.date.hours.start * 60) / 60 * self.height,
            height: Math.round(event.date.to.diff(event.date.from, 'minutes') / 60 * self.height)
          }
          return event
        }).filter((event) => {
          return day.isSame(event.date.from, 'day') && event.placement.top >= 0
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
      week (week) {
        this.date.week = moment(week)
        this.fillDaysList()
      }
    },
    created () {
      // Fill the days events on the component creation
      this.fillDaysList()
    }
  }
</script>
