<script setup>
</script>

<template>
  <section>
    <v-card variant="elevated">
      <v-card-item>
        <div class="launch-sale-grid">

          <span class="sale-text">Early Adopter Launch Promo!</span>
          <h3 class="discount-heading">50% Off*</h3>
          <ul class="category-list">
            <li>Fashion</li>
            <li>Beauty</li>
            <li>Kids</li>
            <li>Summer</li>
            <li>Home</li>
            <li>& More</li>
          </ul>
        </div>
      </v-card-item>
    </v-card>
  </section>
</template>

<style scoped>
.launch-sale-grid {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.discount-heading {
  background-clip: text;
  background-image: linear-gradient(to right, #9f7aea, #3f51b5);
  font-weight: 800;
  color: transparent;
  font-size: 40px;

  text-transform: uppercase;
  white-space: nowrap;
}

.sale-text {
  font-weight: 600;
  font-size: 2xl;
  text-transform: uppercase;
  font-size: 19px;
  color: #c084fc;
}

.category-list {
  display: flex;
  list-style: none;
  padding: 0;
  margin: 0;
}

.category-list li {
  margin-right: 5px;
  text-transform: uppercase;
  font-weight: bold;
  font-size: 19px;
  color: #dc8b29;
}
</style>
