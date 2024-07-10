package commands

import (
	discord "github.com/bwmarrin/discordgo"
	"github.com/pradytpk/go-discord-bot/pkg/bot"
	"github.com/pradytpk/go-discord-bot/pkg/commands/dalle"
	"github.com/sashabaranov/go-openai"
)

const imageCommandName = "image"

func ImageCommand(client *openai.Client) *bot.Command {
	return &bot.Command{
		Name:                     imageCommandName,
		Description:              "Generate creative images from textual descriptions",
		DMPermission:             false,
		DefaultMemberPermissions: discord.PermissionViewChannel,
		SubCommands: bot.NewRouter([]*bot.Command{
			dalle.Command(client),
		}),
	}
}
