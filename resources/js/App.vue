<template>


    <div id="app">
          <!-- <div id="google_translate_element"></div> -->
          <!-- <button @click="callMyMethod">Call My Method</button> -->
            <router-view></router-view>

    </div>

</template>
<script>
export default {
  methods: {
    callMyMethod() {
      this.$myMethod(); // Access the custom method from the plugin
    },
  },
};
</script>
<style>
@import "bootstrap";
@import "datatables.net-bs5";
</style>
