<template lang="">
{{user.login}}
{{user.id}}

</template>
<script>
import { useGetProfile } from "@/hooks/user/useGetProfile";
export default {
  setup() {
    const { user } = useGetProfile();
    console.log(user);
    return {
      user,
    };
  },
};
</script>
<style lang="">
</style>