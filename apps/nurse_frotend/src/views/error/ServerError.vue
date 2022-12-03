<template lang="">
    <div class="page_err">
        <a href="/"><img src="@/assets/img/logo.svg" alt=""></a>
        <h1>500 </h1>
        <router-link class="black-text tdu" to="/">На главную</router-link>
    </div>
</template>
<script>
    export default {};
</script>
<style lang="scss">
    .page_err {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        padding-top: 20%;

        img {
            width: 100%;
        }
    }
</style>