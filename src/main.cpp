#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include <algorithm>

int main()
{
    sf::RenderWindow window(sf::VideoMode(800, 600), "Gatochi");

    sf::Texture coverTexture;
    if (!coverTexture.loadFromFile("assets/Images/gatochi.jpg"))
    {
        return 1;
    }

    sf::Sprite cover(coverTexture);
    const sf::Vector2u coverSize = coverTexture.getSize();
    const float scaleX = static_cast<float>(window.getSize().x) / coverSize.x;
    const float scaleY = static_cast<float>(window.getSize().y) / coverSize.y;
    const float coverScale = std::max(scaleX, scaleY);
    cover.setScale(coverScale, coverScale);
    cover.setPosition(
        (static_cast<float>(window.getSize().x) - coverSize.x * coverScale) / 2.0f,
        (static_cast<float>(window.getSize().y) - coverSize.y * coverScale) / 2.0f);

    sf::Music music;
    if (!music.openFromFile("assets/Music/Fondo.mp3"))
    {
        return 1;
    }
    music.setLoop(true);
    music.play();

    while (window.isOpen())
    {
        sf::Event event{};
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
            {
                window.close();
            }
        }

        window.clear(sf::Color::Black);
        window.draw(cover);
        window.display();
    }

    return 0;
}
