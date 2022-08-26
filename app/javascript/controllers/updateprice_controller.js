import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="updateprice"
export default class extends Controller {
  static targets = ["startdate", "enddate", "price", "priceperday"]

  update() {
    let nbDays = Date.parse(this.enddateTarget.value) - Date.parse(this.startdateTarget.value)
    nbDays = Math.ceil(nbDays/(1000*3600*24))
    const finalPrice = nbDays * parseInt(this.priceperdayTarget.innerHTML)
    if (finalPrice >= 0) {
      this.priceTarget.value = finalPrice
    } else {
      this.priceTarget.value = "Error"
    }
  }
}
