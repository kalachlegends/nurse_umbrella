import { camelCasetoKebab } from "./camelCasetoKebab";

export default function parserStyleByObject(object) {
    const arr = [];
    if (object == undefined) return ""
    Object.keys(object).forEach(function (key, index) {
        arr.push(`${camelCasetoKebab(key)}:${object[key]};`);
    });
    return arr.join("");
}