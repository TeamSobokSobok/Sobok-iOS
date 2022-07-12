# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "WIP"

swiftlint.config_file = './SobokSobok/.swiftlint.yml'
swiftlint.filter_issues_in_diff = true
swiftlint.lint_files inline_mode: true
swiftlint.lint_files fail_on_error: true

if swiftlint.errors.count == 0 && swiftlint.warnings.count == 0
    markdown("## All File Checked 📝")
    markdown("**LGTM✨ No Errors or Warnings Found**")
    markdown("**Good Job!**")
    markdown("| ✅ 	| SwiftLint all file passed!! 고생하셨습니다!! 	|\n|---	|----------------------------------------------	|")
end
