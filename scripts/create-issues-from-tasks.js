#!/usr/bin/env node
/**
 * Script to create GitHub Issues from TASK_TRACKER.md
 * Usage: node scripts/create-issues-from-tasks.js
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

// Read TASK_TRACKER.md
const trackerPath = path.join(__dirname, '..', 'docs', 'TASK_TRACKER.md');
const content = fs.readFileSync(trackerPath, 'utf8');

// Parse tasks
const tasks = [];
const taskRegex = /### (\d+\.\d+) (.+?) \((\d+)\/(\d+)\)([\s\S]*?)(?=###|$)/g;

let match;
while ((match = taskRegex.exec(content)) !== null) {
  const [, number, name, completed, total, body] = match;
  
  // Extract subtasks
  const subtasks = [];
  const subtaskRegex = /- \[ \] (.+)/g;
  let subtaskMatch;
  while ((subtaskMatch = subtaskRegex.exec(body)) !== null) {
    subtasks.push(subtaskMatch[1]);
  }
  
  tasks.push({
    number,
    name,
    completed: parseInt(completed),
    total: parseInt(total),
    subtasks,
  });
}

console.log(`Found ${tasks.length} tasks to create as issues\n`);

// Create GitHub issues
tasks.forEach((task, index) => {
  const title = `Task ${task.number}: ${task.name}`;
  
  const body = `
## Description
Part of Phase 1: MVP Foundation

## Subtasks
${task.subtasks.map(st => `- [ ] ${st}`).join('\n')}

## Acceptance Criteria
- All subtasks completed
- Code passes linting
- Tests pass
- Documentation updated

## Links
- [Task Tracker](https://github.com/Den3112/slovor/blob/main/docs/TASK_TRACKER.md)
- [AI Workflow](https://github.com/Den3112/slovor/blob/main/docs/AI_WORKFLOW.md)
`.trim();

  // Determine labels
  const labels = ['phase-1'];
  if (task.number.startsWith('1.1') || task.number.startsWith('1.2')) {
    labels.push('infrastructure');
  } else if (task.number.startsWith('1.6') || task.number.startsWith('1.7')) {
    labels.push('configuration');
  } else {
    labels.push('setup');
  }
  
  // Create issue
  try {
    const cmd = `gh issue create --title "${title}" --body "${body}" --label "${labels.join(',')}" --assignee @me`;
    
    console.log(`Creating: ${title}`);
    execSync(cmd, { stdio: 'inherit' });
    console.log(`✅ Issue ${index + 1}/${tasks.length} created\n`);
    
    // Rate limit: wait 1 second between requests
    if (index < tasks.length - 1) {
      execSync('sleep 1');
    }
  } catch (error) {
    console.error(`❌ Failed to create issue: ${error.message}`);
  }
});

console.log('\n🎉 All issues created! View at: https://github.com/Den3112/slovor/issues');
console.log('📊 Project board: https://github.com/users/Den3112/projects/1');