import Vue from 'vue'
import Router from 'vue-router'
import HomePage from '~pages/home'

const HelloWorld = () => import('~components/HelloWorld')

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HomePage',
      component: HomePage
    },
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    }
  ]
})
