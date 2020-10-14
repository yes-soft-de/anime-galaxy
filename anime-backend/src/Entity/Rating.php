<?php

namespace App\Entity;

use App\Repository\RatingRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=RatingRepository::class)
 */
class Rating
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string")
     */
    private $userID;

    /**
     * @ORM\Column(type="integer")
     */
    private $animeID;

    /**
     * @ORM\Column(type="integer")
     */
    private $rateValue;

    /**
     * @ORM\Column(type="date", nullable=true)
     */
    private $creationDate;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserID(): ?string
    {
        return $this->userID;
    }

    public function setUserID(string $userID): self
    {
        $this->userID = $userID;

        return $this;
    }

    public function getAnimeID(): ?int
    {
        return $this->animeID;
    }

    public function setAnimeID(int $animeID): self
    {
        $this->animeID = $animeID;

        return $this;
    }

    public function getRateValue(): ?int
    {
        return $this->rateValue;
    }

    public function setRateValue(int $rateValue): self
    {
        $this->rateValue = $rateValue;

        return $this;
    }

    public function getCreationDate(): ?\DateTimeInterface
    {
        return $this->creationDate;
    }

    public function setCreationDate($creationDate): self
    {
        $this->creationDate = new \DateTime($creationDate);

        return $this;
    }
}
