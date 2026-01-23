import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["leagueSelect", "teamSelect", "form"]

  loadTeams() {
    const leagueId = this.leagueSelectTarget.value
    const teamSelect = this.teamSelectTarget

    if (!leagueId) {
      teamSelect.innerHTML = '<option value="">先にリーグを選択してください</option>'
      teamSelect.disabled = true
      return
    }

    fetch(`/search/teams_for_league?league_id=${leagueId}`)
      .then(response => response.json())
      .then(teams => {
        let options = '<option value="">チームを選択してください</option>'
        teams.forEach(team => {
          const displayName = team.name_ja ? `${team.name_ja} (${team.name})` : team.name
          options += `<option value="${team.id}">${displayName}</option>`
        })
        teamSelect.innerHTML = options
        teamSelect.disabled = false
      })
      .catch(error => {
        console.error("Error loading teams:", error)
        teamSelect.innerHTML = '<option value="">エラーが発生しました</option>'
      })
  }
}
