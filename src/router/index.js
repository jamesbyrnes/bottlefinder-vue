import Vue from 'vue'
import Router from 'vue-router'
import Finder from '@/components/Finder'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Finder',
      component: Finder
    }
  ]
})
