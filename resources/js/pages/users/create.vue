<template>
  <v-container class="mt-5">
    <v-card>
      <v-card-header>
        <h4 class="mb-0">
          Add users
          <!-- <v-btn
            to="/users"
            color="error"
            class="float-end"
            >Back</v-btn
          > -->
        </h4>
      </v-card-header>
      <v-card-body>
        <v-progress-circular
          v-if="isLoading"
          :title="isLoadingTitle"
        ></v-progress-circular>
        <v-form
          v-else
          @submit.prevent="saveuser"
        >
          <!-- Name Field -->
          <v-row>
            <v-col
              cols="12"
              md="6"
            >
              <v-text-field
                v-model="users.name"
                label="Name"
                :rules="nameRules"
              ></v-text-field>
            </v-col>

            <!-- Email Field -->
            <v-col
              cols="12"
              md="6"
            >
              <v-text-field
                v-model="users.email"
                label="Email"
                :rules="emailRules"
              ></v-text-field>
            </v-col>

            <!-- Password Field -->
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="users.password"
                  label="Password"
                  :type="showPassword ? 'text' : 'password'"
                  :rules="passwordRules"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-col
              cols="12"
              md="6"
            >
              <v-text-field
                v-model="users.confirmPassword"
                label="Confirm Password"
                type="password"
                :rules="confirmPasswordRules"
              ></v-text-field>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
              <v-checkbox
                v-model="showPassword"
                label="Show Password"
                class="mt-2"
              ></v-checkbox>
            </v-col>
          </v-row>

          <v-btn
            type="submit"
            color="error"
            >SAVE</v-btn
          >
        </v-form>
      </v-card-body>
    </v-card>
  </v-container>
</template>

<script>
import axios from 'axios'
import { useRouter, useRoute } from 'vue-router'
import { ref, onMounted, computed,watch } from 'vue';
export default {
  name: 'UserCreate',
  setup() {
    const router = useRouter()
    const users = ref({
      name: '',
      email: '',
      password: '',
    })
    const isLoading = ref(false)
    const isLoadingTitle = ref('Loading')
    const confirmPasswordRules = [
      value => !!value || 'Please confirm your password',
      value => value === users.value.password || 'Passwords do not match',
    ]

    const showPassword = ref(false)
    const saveuser = async () => {
      // Check if passwords match
      if (users.value.password !== users.value.confirmPassword) {
        // Handle the case where passwords don't match, for example, show an error message
        alert('Passwords do not match')
        return
      }

      isLoading.value = true
      isLoadingTitle.value = 'Saving'

      const formData = new FormData()
      formData.append('name', users.value.name)
      formData.append('email', users.value.email)
      formData.append('password', users.value.password)

      try {
        const res = await axios.post(`http://localhost:8000/api/user`, formData)
        console.log(res)

        router.push({ path: '/user' })
      } catch (error) {
        console.error('Error saving user:', error)
        // Handle error as needed
      } finally {
        isLoading.value = false
        isLoadingTitle.value = 'Loading'
      }
    }

    return {
      users,
      isLoading,
      isLoadingTitle,
      saveuser,
      confirmPasswordRules,
      showPassword,
    }
  },
}
</script>

<style scoped>
.error-message {
  color: white;
}
</style>
