<template lang="">
    <button class="btn">
        <slot>
            
        </slot>
    </button>
</template>
<script>
export default {
    name: 'btn-editor'
}
</script>
<style scoped lang="scss">
@import "@/assets/scss/colors.scss";

.btn {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px;
    border: 1px solid $p-grey;
    background: none;

}
</style>