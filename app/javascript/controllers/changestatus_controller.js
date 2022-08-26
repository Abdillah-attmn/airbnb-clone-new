import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="change-status"
export default class extends Controller {
  static targets = ["status"]
  connect() {
    console.log(2)
  }

  confirm() {
    this.statusTarget.value = "Confirmed"
  }

  cancel(){
    this.statusTarget.value = "Canceled"
  }
}
