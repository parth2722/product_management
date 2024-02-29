<template>
    <div>
        <label :for="address.id" class="custom-label">
            <input type="radio" class="custom-radio" :name="address.name" :readonly="address.readonly" :id="address.id"
                :checked="address.checked">
            <div class="custom-div"></div>
            <div class="custom-div">
                <div class="custom-div">
                    <div :id="address.id" class="custom-address">
                        <p class="custom-paragraph">
                            <span class="custom-span">{{ address.name }}</span>
                            <span class="custom-span">{{ address.type }}</span>
                            <span class="custom-span">{{ address.phone }}</span>
                        </p>
                        <span class="custom-paragraph">{{ address.address }}</span>
                        <button class="custom-button">Deliver Here</button>
                    </div>
                    <div class="custom-div">
                        <button type="button" class="custom-edit-button">EDIT</button>
                    </div>
                </div>
            </div>
        </label>
    </div>
</template>

<script>
export default {
    data() {
        return {
            address: {
                id: "CNTCT5FE69AD5EFB94EB09EC4597F3",
                name: "Parth Hinge",
                type: "HOME",
                phone: "9407158730",
                address: "11/1 Pragati nagar, ujjain, Ujjain, Madhya Pradesh - 456010",
                readonly: true,
                checked: true,
            },
        };
    },
};
</script>

<style scoped>
.custom-label {
    /* Add your label styles here */
}

.custom-radio {
    /* Add your radio button styles here */
}

.custom-div {
    /* Add your div styles here */
}

.custom-address {
    /* Add your address styles here */
}

.custom-paragraph {
    /* Add your paragraph styles here */
}

.custom-button {
    /* Add your button styles here */
}

.custom-edit-button {
    /* Add your edit button styles here */
}
</style>
