<!-- Footer.vue -->

<template>
    <div>
        <footer class="py-2">
            <div class="container mx-auto flex flex-col lg:flex-row items-center justify-between">
                <!-- <div class="mb-4 lg:mb-0">
                <p class="text-lg">&copy; 2024 VuCommerce. All rights reserved.</p>
              </div> -->
                <!-- <div class="flex flex-col lg:flex-row items-center"> -->
                <div class="lg:mb-0 lg:mr-12">
                    <!-- <span class="text-gray-500">Policies:</span> -->
                    <!-- <a href="/returnpolicy" class="ml-2 hover:text-gray-500">Returns Policy</a>
                  <span class="ml-2 text-gray-500">|</span>
                  <a href="/pages/terms" class="ml-2 hover:text-gray-500">Terms of Use</a>
                  <span class="ml-2 text-gray-500">|</span>
                  <a href="/pages/paymentsecurity" class="ml-2 hover:text-gray-500">Security</a>
                  <span class="ml-2 text-gray-500">|</span>
                  <a href="/pages/privacypolicy" class="ml-2 hover:text-gray-500">Privacy</a>
                  <span class="ml-2 text-gray-500">|</span> -->
                    <!-- <a href="https://seller.flipkart.com/fiv" class="ml-2 hover:text-gray-300" target="_blank" rel="noopener noreferrer">Infringement</a> -->
                    <router-link to="/aboutUs" class="hover:text-primary underline-offset-8 coloy" exact>About
                        Us</router-link>
                    <span class="ml-2 underline-offset-8 coloy">|</span>

                    <router-link to="/contactUS" class="hover:text-primary underline-offset-8 coloy" exact>Contact
                        Us</router-link>
                </div>

                <div>
                    <span class="text-gray-500">© 2024</span>
                    <span class="font-bold pr-3"> VuCommerce</span>
                    <span class="text-gray-500 text-sm:md">All rights reserved.</span>
                </div>
            </div>
            <!-- </div> -->
        </footer>
    </div>

</template>

<style scoped>
.coloy {
    color: black;
}
</style>
