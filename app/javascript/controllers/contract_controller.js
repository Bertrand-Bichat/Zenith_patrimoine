import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [
    "mainSection",
    "navbarCloseBtn",
    "uniqContract",
    "newContractForm",
    "editContractForm",
    "fullEditForm",
    "sort",
    "instanceReasonInput",
    "monitoringInput",
    "customerClassInput",
    "customerNameInput",
    "contractNumberInput",
    "prioritizationInput",
    "agentNameInput",
    "delegationInput",
    "navbar",
    "newContractBtn",
    "editContractBtn",
    "agentName",
    "customerName",
    "customerNumber",
    "instanceReason",
    "customerClass",
    "contractNumber",
    "explanation",
    "prioritization",
    "monitoring",
    "dateOfConsideration",
    "gideonNumber",
    "instanceDate",
    "delegation",
    "currentUserName"
  ]

  toggleNavbar() {
    // toggle the hidden class to display navbar
    this.navbarTarget.classList.toggle('closed')
    this.mainSectionTarget.classList.toggle('blur')
  }

  selected(event) {
    // remove the selected class to the old selected contract
    document.querySelector('.contract-selected')?.classList.remove('contract-selected')

    // add the selected class to the selected contract
    event.currentTarget.classList.add('contract-selected')

    // display edit form and scroll to it + hide new form
    this.fullEditFormTarget.classList.remove('hidden')
    this.newContractFormTarget.classList.add('hidden')
    this.editContractBtnTarget.scrollIntoView()

    // modify the contract id & action in the edit form
    const contractID = event.currentTarget.dataset.id
    const newFormID = `edit_contract_${contractID}`
    const newAction = `/instances/${contractID}`
    this.editContractFormTarget.action = newAction
    this.editContractFormTarget.id = newFormID

    // replace edit form inputs with values from selected contract
    const customerID = event.currentTarget.querySelector('.customerName')?.dataset.id
    const agentName = event.currentTarget.querySelector('.agent')?.textContent
    const instanceReason = event.currentTarget.querySelector('.instanceReason')?.textContent
    const customerClass = event.currentTarget.querySelector('.customerClass')?.textContent
    const contractNumber = event.currentTarget.querySelector('.contractNumber')?.textContent
    const monitoring = event.currentTarget.querySelector('.monitoring')?.textContent
    const delegation = event.currentTarget.querySelector('.delegation')?.textContent
    const customerNumber = event.currentTarget.querySelector('.customerNumber')?.textContent
    const explanation = event.currentTarget.querySelector('.explanation')?.textContent
    const prioritization = event.currentTarget.querySelector('.prioritization')?.textContent
    const gideonNumber = event.currentTarget.querySelector('.gideonNumber')?.textContent
    const dateOfConsideration = event.currentTarget.querySelector('.dateOfConsideration')?.textContent
    const instanceDate = event.currentTarget.querySelector('.instanceDate')?.textContent

    this.customerNameTarget.value = customerID
    this.agentNameTarget.value = agentName
    this.instanceReasonTarget.value = instanceReason
    this.customerClassTarget.value = customerClass
    this.contractNumberTarget.value = contractNumber
    this.monitoringTarget.value = monitoring
    this.delegationTarget.value = delegation
    this.customerNumberTarget.value = customerNumber
    this.explanationTarget.value = explanation
    this.prioritizationTarget.value = prioritization
    this.gideonNumberTarget.value = gideonNumber
    this.dateOfConsiderationTarget.value = dateOfConsideration
    this.instanceDateTarget.value = instanceDate

    // find current_user role and name
    const currentUserName = this.currentUserNameTarget.textContent
    const currentUserRole = this.currentUserNameTarget.dataset.role

    // disabled all edit form inputs if selected contract agent name !== currentUserName
    if ((currentUserRole === 'assistant') && (agentName !== currentUserName)) {
      this.instanceReasonTarget.disabled = true
      this.customerClassTarget.disabled = true
      this.contractNumberTarget.disabled = true
      this.explanationTarget.disabled = true
    }
  }

  newContract() {
    // toggle the class to new & edit contract form
    this.newContractFormTarget.classList.toggle('hidden')
    this.fullEditFormTarget.classList.add('hidden')
    document.querySelector('.contract-selected')?.classList.remove('contract-selected')
    this.newContractBtnTarget.scrollIntoView()
  }

  editContract() {
    // remove the class to edit contract form
    this.fullEditFormTarget.classList.add('hidden')
    document.querySelector('.contract-selected')?.classList.remove('contract-selected')
    this.editContractBtnTarget.scrollIntoView()
  }

  erase() {
    // reset each input select value to blank
    this.sortTargets.forEach((sort) => {
      sort.value = ''
    });

    // display all contracts in the list
    this.uniqContractTargets.forEach((uniqContract) => {
      uniqContract.classList.remove('hidden')
    });

    // remove selected class and hide new & edit forms
    document.querySelector('.contract-selected')?.classList.remove('contract-selected')
    this.fullEditFormTarget.classList.add('hidden')
    this.newContractFormTarget.classList.add('hidden')
  }

  contractsSorting() {
    // display all contracts in the list
    this.uniqContractTargets.forEach((uniqContract) => {
      uniqContract.classList.remove('hidden')
    });

    // hide contracts thanks to all inputs values
    this.instanceReasonSort()
    this.monitoringSort()
    this.customerClassSort()
    this.customerNameSort()
    this.contractNumberSort()
    this.agentSort()
    this.delegationSort()
    this.prioritizationSort()
  }

  instanceReasonSort() {
    // sort contracts with value selected
    const instanceReasonInput = this.instanceReasonInputTarget.value
    if (instanceReasonInput === '') {
        // nothing
    } else {
      this.uniqContractTargets.forEach((uniqContract) => {
        if (uniqContract.querySelector('.instanceReason').textContent !== instanceReasonInput) {
          uniqContract.classList.add('hidden')
        }
      });
    }
  }

  monitoringSort() {
    // sort contracts with value selected
    const monitoringInput = this.monitoringInputTarget.value
    if (monitoringInput === '') {
        // nothing
    } else {
      this.uniqContractTargets.forEach((uniqContract) => {
        if (uniqContract.querySelector('.monitoring').textContent !== monitoringInput) {
          uniqContract.classList.add('hidden')
        }
      });
    }
  }

  customerClassSort() {
    // sort contracts with value selected
    const customerClassInput = this.customerClassInputTarget.value
    if (customerClassInput === '') {
        // nothing
    } else {
      this.uniqContractTargets.forEach((uniqContract) => {
        if (uniqContract.querySelector('.customerClass').textContent !== customerClassInput) {
          uniqContract.classList.add('hidden')
        }
      });
    }
  }

  customerNameSort() {
    // sort contracts with value selected
    const customerNameInput = this.customerNameInputTarget.value
    if (customerNameInput === '') {
        // nothing
    } else {
      this.uniqContractTargets.forEach((uniqContract) => {
        if (uniqContract.querySelector('.customerName').textContent !== customerNameInput) {
          uniqContract.classList.add('hidden')
        }
      });
    }
  }

  contractNumberSort() {
    // sort contracts with value selected
    const contractNumberInput = this.contractNumberInputTarget.value
    if (contractNumberInput === '') {
        // nothing
    } else {
      this.uniqContractTargets.forEach((uniqContract) => {
        if (uniqContract.querySelector('.contractNumber').textContent !== contractNumberInput) {
          uniqContract.classList.add('hidden')
        }
      });
    }
  }

  agentSort() {
    // sort contracts with value selected
    const agentNameInput = this.agentNameInputTarget.value
    if (agentNameInput === '') {
        // nothing
    } else {
      this.uniqContractTargets.forEach((uniqContract) => {
        if (uniqContract.querySelector('.agent').textContent !== agentNameInput) {
          uniqContract.classList.add('hidden')
        }
      });
    }
  }

  delegationSort() {
    // sort contracts with value selected
    const delegationInput = this.delegationInputTarget.value
    if (delegationInput === '') {
        // nothing
    } else {
      this.uniqContractTargets.forEach((uniqContract) => {
        if (uniqContract.querySelector('.delegation').textContent !== delegationInput) {
          uniqContract.classList.add('hidden')
        }
      });
    }
  }

  prioritizationSort() {
    // sort contracts with value selected
    const prioritizationInput = this.prioritizationInputTarget.value
    if (prioritizationInput === '') {
        // nothing
    } else {
      this.uniqContractTargets.forEach((uniqContract) => {
        if (uniqContract.querySelector('.prioritization').textContent !== prioritizationInput) {
          uniqContract.classList.add('hidden')
        }
      });
    }
  }
}
