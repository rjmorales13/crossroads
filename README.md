# Crossroads

A Mac app that reads your Jira and shows, release by release and sprint by sprint, how many tickets
reached your "QA passed" status and who moved them there.

It only reads Jira, with your own account. Your API token is kept in your Mac's Keychain.

## Install

Needs a Mac with an Apple chip (M1 or newer).

1. Open the **Terminal** app (press Command+Space, type `Terminal`, press Return).
2. Copy this line, paste it into Terminal, and press Return:

   ```
   curl -fsSL https://raw.githubusercontent.com/rjmorales13/crossroads/main/install.sh | bash
   ```

3. Crossroads opens. From now on, open it with the **Crossroads** icon on your Desktop.

## First time

1. Enter your Jira address and email.
2. Click **Open the Atlassian token page**, create a token there, copy it, and paste it into **API token**.
3. Click **Connect**.
4. If someone sent you a settings file, click **Load a settings file…**, choose it, and click **Save**.
5. Click **Run report**.

## Updates

When a new version is out, Crossroads shows a banner at the top with an **Update now** button.
Click it; the app closes and reopens on the new version.

## Remove

Drag Crossroads from Applications to the Trash and delete the Crossroads icon on your Desktop.
